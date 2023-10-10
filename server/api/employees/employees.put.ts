import { Employees, PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export default defineEventHandler(async (request) => {
    const body: Employees = await readBody(request);
    prisma.employees.update({
        data: body,
        where: {
            userId: body.userId
        }
    })
})