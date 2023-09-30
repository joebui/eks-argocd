resource "aws_iam_policy" "elb_controller" {
  name   = "AWSLoadBalancerControllerIAMPolicy"
  policy = templatefile("${path.module}/policies/elb_controller.json", {})
}

resource "aws_iam_role" "elb_controller" {
  name = "AmazonEKSLoadBalancerControllerRole"
  assume_role_policy = templatefile("${path.module}/policies/assume.json", {
    region  = "ap-southeast-1",
    oidc_id = "5E8959892E50AA5D5B21F3680680AD5E"
  })
}

resource "aws_iam_policy_attachment" "elb_controller" {
  name       = "AWSLoadBalancerControllerIAMPolicy"
  policy_arn = aws_iam_policy.elb_controller.arn
  roles      = [aws_iam_role.elb_controller.id]
}
