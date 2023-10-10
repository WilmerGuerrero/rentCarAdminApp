import { FuelTypes, PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const body: FuelTypes = await readBody(request);
    prisma.vehicleTypes.delete({
        where: {
            id: body.id
        }
    })
})