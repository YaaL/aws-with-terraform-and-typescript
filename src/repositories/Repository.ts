import { DynamoDBClient } from "@aws-sdk/client-dynamodb";

export class Repository {
    readonly client: DynamoDBClient
    constructor() {
        this.client = new DynamoDBClient({ region: process.env.AWS_REGION || 'eu-west-2' });
    }
}
