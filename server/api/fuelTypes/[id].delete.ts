import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default defineEventHandler(async (handler) => {
    const id = Number(handler.context.params?.id);
    await prisma.fuelTypes.delete({
        where: {
            id
        }
    })

    return { statusCode: 204 }    
})