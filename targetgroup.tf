resource "aws_lb_target_group" "DSH" {
  name        = "DSH-TargetGroup"
  depends_on  = [aws_vpc.FP]
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.FP.id
  target_type = "instance"

}

resource "aws_lb_target_group" "DSW" {
  name        = "DSW-TargetGroup"
  depends_on  = [aws_vpc.FP]
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.FP.id
  target_type = "instance"

}
