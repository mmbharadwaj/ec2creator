#! /usr/bin/bash
# This Script will create S3 bucket and tag the bucket with appropriate name.

# To check if access key is setup in your system 


if ! grep aws_access_key_id ~/.aws/config; then
   if ! grep aws_access_key_id ~/.aws/credentials; then
   echo "AWS config not found or you don't have AWS CLI installed"
   exit 1
   fi
fi

# read command will prompt you to enter the name of bucket name you wish to create 


read -r -p  "Enter the name of the bucket:" bucketname
echo $bucketname

# Creating first function to create a bucket 

function createbucket()
   {
    aws s3api  create-bucket --bucket $bucketname --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
   }


# Creating Second function to tag a bucket 

function tagbucket()    {
    
   aws s3api  put-bucket-tagging --bucket $bucketname --tagging 'TagSet=[{Key=Name,Value="'$bucketname'"}]'
}


# echo command will print on the screen 

echo "Creating the AWS S3 bucket and Tagging it !! "
echo ""
createbucket $bucketname    # Calling the createbucket function  
tagbucket $bucketname      # calling our tagbucket function
echo "AWS S3 bucket $bucketname created successfully"
echo "AWS S3 bucket $bucketname tagged successfully "
