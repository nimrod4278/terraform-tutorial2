import json
import boto3


def lambda_handler(event, context):

    iam = boto3.resource('iam')
    
    Engineering_role = iam.Role('Engineering_role')
    Finance_role = iam.Role('Finance_role')
    
    admin_arn = 'arn:aws:iam::aws:policy/AdministratorAccess'
    billing_arn = 'arn:aws:iam::aws:policy/job-function/Billing'
    

    admin_policy = iam.Policy(admin_arn)
    
    admin_list = []
    for admin in admin_policy.attached_roles.all():
        admin_list.append(admin.role_name)
    
    if 'Engineering_role' in admin_list:

        Engineering_role.detach_policy(
            PolicyArn=admin_arn
            )
        
        Finance_role.detach_policy(
            PolicyArn=billing_arn
            )
            
        Engineering_role.attach_policy(
            PolicyArn=billing_arn
            )
        
        Finance_role.attach_policy(
            PolicyArn=admin_arn
            )
    else:
        Engineering_role.detach_policy(
            PolicyArn=billing_arn
            )
        
        Finance_role.detach_policy(
            PolicyArn=admin_arn
            )
            
        Engineering_role.attach_policy(
            PolicyArn=admin_arn
            )
        
        Finance_role.attach_policy(
            PolicyArn=billing_arn
            )
            
    return {}
