ata "aws_ebs_volume" "production_volume" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "tag:Name"
    values = ["Production"]
  }
}

resource "aws_ebs_snapshot" "production_snapshot" {
  volume_id = "${data.aws_ebs_volume.prod_volume.id}"

  tags {
    Name = "Production"
  }
}

resource "aws_ebs_volume" "from_production_snapshot" {
  availability_zone = "us-west-2a"
  snapshot_id       = "${aws_ebs_snapshot.production_snapshot.id}"
  size              = 40

  tags {
    Name = "Non-Production"
  }
}

resource "aws_instance" "non_production" {
  ami               = "your_AMI"
  availability_zone = "us-west-2a"
  instance_type     = "t2.micro"

  tags {
    Name = "Non-Production"
  }
}

resource "aws_volume_attachment" "non_production" {
  device_name = "/dev/xvdf"
  volume_id   = "${aws_ebs_volume.from_production_snapshot.id}"
  instance_id = "${aws_instance.non_production.id}"
}
