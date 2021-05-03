import { PutItemCommand, PutItemCommandInput } from "@aws-sdk/client-dynamodb";
import { Repository } from "./Repository";

type Event = {
    id: string;
    data: string;
  };

const enum EventAttributs {
    id = "Id",
    idType = "S",
    data = "Data",
    dataType = "S",
    ttl = "ttl",
    ttlType = "N",
}

export default class EventsRepository extends Repository {
    private readonly productsTable = "events-sandbox"

    async create(event: Event){

        const secondsInAnHour = 3600;
        const secondsSinceEpoch = Math.round(Date.now() / 1000);
        const hoursTillExpire = 24
        const expirationTime = secondsSinceEpoch + hoursTillExpire * secondsInAnHour;

        const item = {
            [EventAttributs.id]: {[EventAttributs.idType]: event.id},
            [EventAttributs.data]: {[EventAttributs.dataType]: event.data},
            [EventAttributs.ttl]: {[EventAttributs.ttlType]: `${expirationTime}`},
        }
        const params: PutItemCommandInput = {
            TableName: this.productsTable,
            Item: item
          };

        await this.client.send(new PutItemCommand(params))

        return item
    }
}
