import json

import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('visitcount')

def lambda_handler(event, context):

    response = table.get_item(Key= {'appname' : 'ResumeApp'} )
    count = response["Item"]["loadcount"]

    # increment string version of visit count
    new_count = str(int(count)+1)
    response = table.update_item(
        Key={'appname': 'ResumeApp'},
        UpdateExpression='set loadcount = :c',
        ExpressionAttributeValues={':c': new_count},
        ReturnValues='UPDATED_NEW'
        )

    return {
        'statusCode': 200,
        'body': new_count
    }
#end lambda_handler