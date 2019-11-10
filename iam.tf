resource "aws_iam_role" "Engineering_role" {
  name = "Engineering_role"

  assume_role_policy = "${file("roles/Engineering_role.json")}"
}

resource "aws_iam_role" "Finance_role" {
  name = "Finance_role"

  assume_role_policy = "${file("roles/Finance_role.json")}"
}

resource "aws_iam_policy_attachment" "admin-attach" {
  name       = "admin-attachment"
  roles      = ["Engineering_role"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy_attachment" "billing-attach" {
  name       = "billing-attachment"
  roles      = ["Finance_role"]
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}