resource "null_resource" "instance_state_checker" {
    provisioner "local-exec" {
        command = "state='none'; while  [ $state !=  'running' ]; do state=$(aws ec2 describe-instance-status --instance-id ${aws_instance.ec2_instance.id} --query 'InstanceStatuses[*].InstanceState.Name' --output text); echo $state; done ; echo 'Instance running'"
        # command = "aws ec2 describe-instance-status --instance-id ${aws_instance.myEc2.id}"
    }
}

# state="no"; while  [ $state !=  'running' ]; do state=$(aws ec2 describe-instance-status --instance-id i-0be9eff25eacf0cf3 --query 'InstanceStatuses[*].InstanceStatus.Details.Status' --output text); echo $state; done ; echo "Instance running"
# aws ec2 describe-instance-status --instance-id i-0eced28959ffac148 --query 'InstanceStatuses[*].InstanceState.Name' --output text