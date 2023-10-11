import { PrismaClient } from "@prisma/client";
import { BaseInventoryFields } from "~/typings/baseInventoryFields";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const body: BaseInventoryFields = await readBody(request);    
    const upsertedMake = await prisma.vehicleTypes.upsert({
        where: {
            name: body.name
        },
        create: body,
        update: body
    });

    return {
        statusCode: 200,
        upsertedMake
    }
})