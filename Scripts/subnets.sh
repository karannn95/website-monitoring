# Create Subnets
for i in ${!SUBNETS[@]}; do
  SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block ${SUBNETS[i]} --availability-zone ${ZONES[i]} --query 'Subnet.SubnetId' --output text)
  aws ec2 create-tags --resources $SUBNET_ID --tags Key=Name,Value=${SUBNET_NAMES[i]}
  echo "Created Subnet ${SUBNET_NAMES[i]} with CIDR ${SUBNETS[i]}"
done

# Enable auto-assign public IP on the first two subnets
for i in {0..1}; do
  aws ec2 modify-subnet-attribute --subnet-id $(aws ec2 describe-subnets --filters Name=cidrBlock,Values=${SUBNETS[i]} --query 'Subnets[0].SubnetId' --output text) --map-public-ip-on-launch
  echo "Enabled public IP for subnet ${SUBNET_NAMES[i]}"
done
