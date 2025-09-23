# ------------------------------
# Step 1: Provider
# Choosing the "country" where we will build our city
# ------------------------------
provider "aws" {
  region = "us-east-1"
}

# ------------------------------
# Step 2: VPC (The City Walls)
# This is our private city, defined by a CIDR block (address space).
# Think of this as drawing the boundaries of the whole city.
# ------------------------------
variable "cidr" {
  default = "10.0.0.0/16" # Our city's address system: ~65,000 houses possible
}

resource "aws_vpc" "myVpc" {
  cidr_block = var.cidr
}

# ------------------------------
# Step 3: Subnet (Neighborhood in the City)
# Inside the city, we build a neighborhood with 256 houses.
# Marked as public, so each house can get a visible street number (public IP).
# ------------------------------
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myVpc.id
  cidr_block              = "10.0.0.0/24" # 256 addresses for this neighborhood
  availability_zone       = "us-east-1a"  # Place in one district (AZ)
  map_public_ip_on_launch = true          # Houses here get street numbers (public IPs)
}

# ------------------------------
# Step 4: Internet Gateway (Main City Gate)
# A huge gate on the city wall that connects the city to the outside highway (internet).
# Without it, no one inside can reach the outside world.
# ------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVpc.id
}

# ------------------------------
# Step 5: Route Table (Google Maps for Traffic)
# These are the maps for how traffic flows inside/outside the city.
# Adding a route that says "for anywhere in the world (0.0.0.0/0), 
# take the highway through the main gate (IGW)."
# ------------------------------
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myVpc.id

  route {
    cidr_block = "0.0.0.0/0"                 # Any destination
    gateway_id = aws_internet_gateway.igw.id # Go out through the main gate
  }
}

# ------------------------------
# Step 6: Attach Maps to Neighborhood
# Give this neighborhood (subnet) access to the maps (route table).
# Now the cars (packets) in this neighborhood know how to exit to the internet.
# ------------------------------
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

# ------------------------------
# Step 7: Security Group (Bodyguards at Each House)
# These are the guards that stand at every house door (EC2).
# Rules:
# - Allow visitors to enter through door 80 (HTTP).
# - Allow you to enter through door 22 (SSH).
# - Let residents leave freely to anywhere.
# ------------------------------
resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myVpc.id

  # Visitors can come in through HTTP (port 80) from anywhere
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # You can enter via SSH (port 22) from anywhere (⚠️ not safe in real life!)
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Residents can leave the city to anywhere (outbound traffic allowed)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"] # Anywhere
  }

  tags = {
    Name = "Web-sg"
  }
}

# ------------------------------
# Step 8: Key Pair (House Key)
# This is your physical key to unlock the house (EC2 instance).
# Without it, you cannot get inside.
# ------------------------------
resource "aws_key_pair" "example" {
  key_name   = "terraform-demo-shaka-g"
  public_key = file("~/.ssh/id_rsa.pub")
}

# ------------------------------
# Step 9: EC2 Instance (The House)
# Finally, we build a house (server) in the neighborhood.
# Blueprint = AMI (Ubuntu).
# Guards = Security group.
# House key = Key pair.
# ------------------------------
resource "aws_instance" "server" {
  ami                    = "ami-0261755bbcb8c4a84" # Ubuntu "blueprint"
  instance_type          = "t2.micro"              # Tiny apartment (free tier)
  key_name               = aws_key_pair.example.key_name
  vpc_security_group_ids = [aws_security_group.webSg.id] # Attach bodyguards
  subnet_id              = aws_subnet.sub1.id            # Place house in public neighborhood

  # ------------------------------
  # Connection: how you (the city owner) enter your house
  # ------------------------------
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa") # Your private key (the key that fits the lock)
    host        = self.public_ip        # Connect to your house via its street number (public IP)
  }

  # ------------------------------
  # Provisioners: Moving Truck
  # You bring furniture (files) into the house and set it up.
  # ------------------------------

  # First, load your furniture: copy app.py inside the house
  provisioner "file" {
    source      = "app.py"
    destination = "/home/ubuntu/app.py"
  }

  # Then set up the house (install utilities, arrange things)
  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance' ", # Just to say hi
      "sudo apt update -y",                     # Update package list
      "sudo apt-get install -y python3-pip",    # Install pip
      "cd /home/ubuntu",
      "sudo pip3 install flask", # Install Flask (⚠️ done globally, not in venv)
      "sudo python3 app.py"      # Run your app (like turning the lights on)
    ]
  }
}
