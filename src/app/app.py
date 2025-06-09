import json

def lambda_handler(event, context):
    """Simple Hello World Lambda function for API Gateway"""
    try:
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"  # Important for CORS
            },
            "body": json.dumps({
                "message": "Hello World from Python 3.11 Lambda!",
                "details": "This is a minimal working example"
            })
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({
                "error": "Internal Server Error",
                "details": str(e)
            })
        }
