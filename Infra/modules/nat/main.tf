
resource "aws_eip" "nat" {
  count = 2
  tags = {
    Name = "${var.vpc_name}-nat-eip-${count.index}"
  }
}



resource "aws_nat_gateway" "demo-natgw" {
  count         = length(var.public_subnet_ids)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]

  tags = {
    Name = "${var.vpc_name}-nat-gw-${count.index}"
  }

}
