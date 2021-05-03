import { PutItemCommand, PutItemCommandInput } from "@aws-sdk/client-dynamodb";
import { Repository } from "./Repository";

type Product = {
    id: string;
    categoryId: string;
    name: string;
    status: string;
  };

const enum ProductAttributs {
    id = "Id",
    idType = "S",
    categoryId = "CategoryId",
    categoryIdType = "S",
    name = "Name",
    nameType = "S",
    status = "Status",
    statusType = "S"
}

export default class ProductsRepository extends Repository {
    private readonly productsTable = "products-sandbox"

    async create(product: Product){
        const params: PutItemCommandInput = {
            TableName: this.productsTable,
            Item: {
                [ProductAttributs.id]: {[ProductAttributs.idType]: product.id},
                [ProductAttributs.categoryId]: {[ProductAttributs.categoryIdType]: product.categoryId},
                [ProductAttributs.name]: {[ProductAttributs.nameType]: product.name},
                [ProductAttributs.status]: {[ProductAttributs.statusType]: product.status},
            }
          };

        await this.client.send(new PutItemCommand(params))
    }
}
