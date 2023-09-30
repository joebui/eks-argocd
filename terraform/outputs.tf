output "AWSLoadBalancerControllerIAMPolicy" {
  value = aws_iam_role.elb_controller.arn
}
