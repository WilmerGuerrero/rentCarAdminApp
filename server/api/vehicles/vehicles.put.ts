import { PrismaClient, Vehicles } from "@prisma/client";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const body: Vehicles = await readBody(request);
    prisma.vehicles.update({
        data: body,
        where: {
            id: body.id
        }
    })
})