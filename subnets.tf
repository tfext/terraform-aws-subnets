data "aws_vpc" "vpc" {
  id = var.vpc_id
}

locals {
  vpc_name = lookup(data.aws_vpc.vpc.tags, "Name")
}

resource "aws_subnet" "subnet" {
  count                   = var.subnet_count
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.cidr_block, var.subnet_cidr_bits, count.index)
  availability_zone       = module.aws_utils.availability_zones[count.index]
  map_public_ip_on_launch = var.subnet_type == "public"

  tags = merge(
    {
      Name = join("-", [
        local.vpc_name,
        var.name,
        module.aws_utils.availability_zone_suffixes[count.index]
      ])
      subnet_type = var.subnet_type
    },
    module.utils.default_tags,
    coalesce(var.extra_tags, {})
  )

  lifecycle {
    # Allow import of non-standard subnets without terraform
    # wanting to immediately re-create everything
    ignore_changes = [cidr_block]
  }
}

resource "aws_route_table_association" "subnet" {
  count          = var.subnet_count
  route_table_id = element(var.route_table_ids, count.index)
  subnet_id      = aws_subnet.subnet.*.id[count.index]
}

