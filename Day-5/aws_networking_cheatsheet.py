#!/usr/bin/env python3
"""
AWS Networking Concepts Generator
Creates educational content about AWS networking using memorable analogies
"""


def print_aws_networking_cheatsheet():
    """Generate a comprehensive AWS networking cheat sheet"""

    print("🏙️ AWS NETWORKING CHEAT SHEET - NEVER FORGET EDITION")
    print("=" * 60)

    print("\n🧠 THE CITY ANALOGY (Your Memory Anchor)")
    print("-" * 40)
    concepts = {
        "🏙️ VPC": "Your entire private city",
        "🚪 Internet Gateway": "Main city gate (only 1 per city)",
        "🏘️ Public Subnet": "Beachfront neighborhood (everyone can visit)",
        "🏘️ Private Subnet": "Gated community (residents only)",
        "🛡️ Security Groups": "Personal bodyguards (follow you around)",
        "🚨 NACLs": "Neighborhood checkpoints (stationary guards)",
        "🗺️ Route Tables": "GPS navigation system",
        "🔢 CIDR": "Address/ZIP code system",
    }

    for concept, analogy in concepts.items():
        print(f"{concept:<20} = {analogy}")

    print("\n🔢 CIDR MEMORY TRICKS")
    print("-" * 40)
    cidr_examples = {
        "/8": "16,777,216 addresses (Megacity like Tokyo)",
        "/16": "65,536 addresses (Big city)",
        "/24": "256 addresses (Small neighborhood)",
        "/32": "1 address (One specific house)",
    }

    for cidr, description in cidr_examples.items():
        print(f"{cidr:<4} = {description}")

    print("\n🚦 TRAFFIC FLOW STORY")
    print("-" * 40)
    flow_steps = [
        "1. 🌍 User on internet wants to visit your website",
        "2. 🚪 Request hits Internet Gateway (city main gate)",
        "3. 🗺️ IGW checks Route Table (GPS: where should this go?)",
        "4. 🏘️ Route Table sends to Public Subnet (beachfront)",
        "5. 🛡️ Security Group checks (personal bodyguard: allowed?)",
        "6. 🖥️ Web server receives request",
        "7. 🗄️ Web server queries private database (internal call)",
        "8. 🛡️ Database Security Group allows (web server is trusted)",
        "9. 📤 Response flows back through same path",
    ]

    for step in flow_steps:
        print(step)

    print("\n🔒 SECURITY LAYERS")
    print("-" * 40)
    security_layers = {
        "Internet Gateway": "Controls what can enter/leave your VPC",
        "Route Tables": "Controls where traffic goes",
        "NACLs": "Subnet-level firewall (stateless)",
        "Security Groups": "Instance-level firewall (stateful)",
        "IAM": "Who can do what actions",
    }

    for layer, purpose in security_layers.items():
        print(f"• {layer:<18}: {purpose}")

    print("\n💡 NEVER FORGET RULES")
    print("-" * 40)
    rules = [
        "• Smaller CIDR /number = BIGGER network",
        "• Public subnet = has route to Internet Gateway",
        "• Private subnet = no direct internet route",
        "• Security Groups = ALLOW rules only (deny by default)",
        "• NACLs = ALLOW and DENY rules (default deny)",
        "• One VPC = One Internet Gateway (max)",
        "• Route table decides: local traffic vs internet traffic",
    ]

    for rule in rules:
        print(rule)


def generate_terraform_equivalents():
    """Show how current DigitalOcean setup maps to AWS concepts"""

    print("\n\n🔄 YOUR DIGITALOCEAN ↔ AWS MAPPING")
    print("=" * 60)

    mappings = {
        "DigitalOcean Droplet": "AWS EC2 Instance",
        "DO Spaces": "AWS S3 Bucket",
        "DO Load Balancer": "AWS ALB/ELB",
        "DO Firewall": "AWS Security Groups",
        "DO VPC": "AWS VPC",
        "DO Reserved IP": "AWS Elastic IP",
        "Cloudflare R2": "AWS S3 (compatible API)",
        "Terraform Cloud": "AWS-agnostic state management",
    }

    for do_service, aws_equivalent in mappings.items():
        print(f"{do_service:<25} ≈ {aws_equivalent}")


def main():
    """Main function to run the cheat sheet generator"""
    print_aws_networking_cheatsheet()
    generate_terraform_equivalents()

    print("\n\n📁 FILES GENERATED:")
    print("• infrastructure-diagram.md (Mermaid + explanations)")
    print("• infrastructure.dot (Graphviz source)")
    print("• infrastructure.png (Visual diagram)")
    print("• infrastructure.svg (Scalable diagram)")

    print("\n🚀 QUICK COMMANDS:")
    print("• View PNG: xdg-open infrastructure.png")
    print("• Regenerate: dot -Tpng infrastructure.dot -o infrastructure.png")
    print("• Edit concepts: vim infrastructure-diagram.md")


if __name__ == "__main__":
    main()
