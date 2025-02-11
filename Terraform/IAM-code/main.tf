# Creating a Group
resource "aws_iam_group" "group" {
  name = "${var.group_tag}-group"
}

# Creating multiple users
resource "aws_iam_user" "users" {
  count = length(var.given_user)
  name = var.given_user[count.index]
}

# Adding the users to the group
resource "aws_iam_group_membership" "users_group" {
  name = "${var.group_tag}-group-membership"
  count = length(var.given_user)
  users = [aws_iam_user.users[count.index].name]
  group = aws_iam_group.group.name
}

# IAM Policy Attachment to Group
resource "aws_iam_group_policy_attachment" "lb_ro" {
  group   = aws_iam_group.group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
