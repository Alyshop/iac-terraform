resource "aws_iam_role" "iam_role" {
  name               = "ec2-s3-access"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy_attachment" "s3_access" {
  name       = "s3-access-attach"
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe01e"  # Substitua pela AMI desejada
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.id

  tags = {
    Name = "MyEC2Instance"
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.iam_role.name
}

output "iam_role_arn" {
  value = aws_iam_role.iam_role.arn
}

output "instance_id" {
  value = aws_instance.web.id
}
