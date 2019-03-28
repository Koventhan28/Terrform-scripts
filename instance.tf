#Creating a basic Ansible
resource "aws_instance" "ansible" {
 instance_type = "${var.instance_type}"
 ami = "ami-5b673c34"
 security_groups = ["${aws_security_group.security_group.id}"]
 subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
 key_name = "Koventhan1"
 count = 1
 associate_public_ip_address = true
 tags = {
    Name = "ansible"
  }


user_data = <<-EOF
            #!/bin/bash
            yum install ansible ansible-doc -y
            # This command is used for creating keygen without giving any input to the system
            useradd ans
            echo "ans:ans"| chpasswd
            echo "ans ALL=(ALL) ALL" >> visudo
            #echo "PasswordAuthentication yes" >>  /etc/ssh/ssh_config
            sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
            systemctl restart sshd
            cat /dev/zero | ssh-keygen -q -N ""
            #cd /.ssh/
            #echo "yes" | ssh-copy-id
            hostnamectl set-hostname ansible
            EOF
}

resource "aws_eip" "default" {
  instance = "${aws_instance.ansible.id}"
  vpc      = true
}
#Creating a basic instance 1
resource "aws_instance" "instance-1" {
 instance_type = "${var.instance_type}"
 ami = "ami-5b673c34"
 security_groups = ["${aws_security_group.security_group.id}"]
 subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
 key_name = "Koventhan1"
 count = 1
 associate_public_ip_address = true
 tags = {
    Name = "instance-1"
  }


user_data = <<-EOF
            #!/bin/bash
            enable the repository and then isntall ansible packages
            hostnamectl set-hostname MSR-test-Instance-1
            useradd ans
            echo "ans:ans"| chpasswd
            echo "ans ALL=(ALL) ALL" >> visudo
            sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
            systemctl restart sshd
            EOF
}
#Creating a basic instance 2
resource "aws_instance" "instance-2" {
 instance_type = "${var.instance_type}"
 ami = "ami-5b673c34"
 security_groups = ["${aws_security_group.security_group.id}"]
 subnet_id = "${element(aws_subnet.public.*.id,count.index)}"
 key_name = "Koventhan1"
 count = 1
 associate_public_ip_address = true
 tags = {
    Name = "instance2"
  }


user_data = <<-EOF
            #!/bin/bash
            hostnamectl set-hostname MSR-test-Instance-2
            useradd ans
            echo "ans:ans"| chpasswd
            echo "ans ALL=(ALL) ALL" >> visudo
            sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
            systemctl restart sshd
            EOF
}
