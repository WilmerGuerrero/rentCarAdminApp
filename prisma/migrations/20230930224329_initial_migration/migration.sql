-- CreateTable
CREATE TABLE "FuelTypes" (
    "id" SERIAL NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FuelTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicleTypes" (
    "id" SERIAL NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "vehicleTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Makes" (
    "id" SERIAL NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Makes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Models" (
    "id" SERIAL NOT NULL,
    "makeId" INTEGER NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Models_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vehicles" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "chassisNumber" TEXT NOT NULL,
    "engineNumber" TEXT NOT NULL,
    "plateNumber" TEXT NOT NULL,
    "vehicleTypeId" INTEGER NOT NULL,
    "modelId" INTEGER NOT NULL,
    "makeName" TEXT NOT NULL,
    "fuelTypeId" INTEGER NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Vehicles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "identificationNumber" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Clients" (
    "userId" INTEGER NOT NULL,
    "creditCardNumber" TEXT NOT NULL,
    "creditLimit" DECIMAL(65,30) NOT NULL,
    "personType" INTEGER NOT NULL,

    CONSTRAINT "Clients_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Employees" (
    "userId" INTEGER NOT NULL,
    "isAdmin" BOOLEAN NOT NULL DEFAULT false,
    "shift" INTEGER NOT NULL,
    "comissionPercent" DECIMAL(65,30) NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "exitDate" TIMESTAMP(3),

    CONSTRAINT "Employees_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Inspections" (
    "id" SERIAL NOT NULL,
    "inspectionType" INTEGER NOT NULL,
    "vehicleId" INTEGER NOT NULL,
    "clientId" INTEGER NOT NULL,
    "fuelAmount" INTEGER NOT NULL,
    "hasSpareTire" BOOLEAN NOT NULL,
    "hasScissorJack" BOOLEAN NOT NULL,
    "hasGlassBreaks" BOOLEAN NOT NULL,
    "tiresHealth" JSONB NOT NULL,
    "employeeId" INTEGER NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Inspections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Rents" (
    "id" SERIAL NOT NULL,
    "employeeId" INTEGER NOT NULL,
    "clientId" INTEGER NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "returnDate" TIMESTAMP(3) NOT NULL,
    "pricePerDay" INTEGER NOT NULL,
    "daysUsed" INTEGER NOT NULL,
    "comments" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updateAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Rents_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FuelTypes_name_key" ON "FuelTypes"("name");

-- CreateIndex
CREATE UNIQUE INDEX "vehicleTypes_name_key" ON "vehicleTypes"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Makes_name_key" ON "Makes"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Models_name_key" ON "Models"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Vehicles_chassisNumber_key" ON "Vehicles"("chassisNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Vehicles_engineNumber_key" ON "Vehicles"("engineNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Vehicles_plateNumber_key" ON "Vehicles"("plateNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Users_identificationNumber_key" ON "Users"("identificationNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Clients_userId_key" ON "Clients"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Clients_creditCardNumber_key" ON "Clients"("creditCardNumber");

-- CreateIndex
CREATE UNIQUE INDEX "Employees_userId_key" ON "Employees"("userId");

-- AddForeignKey
ALTER TABLE "Models" ADD CONSTRAINT "Models_makeId_fkey" FOREIGN KEY ("makeId") REFERENCES "Makes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vehicles" ADD CONSTRAINT "Vehicles_vehicleTypeId_fkey" FOREIGN KEY ("vehicleTypeId") REFERENCES "vehicleTypes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vehicles" ADD CONSTRAINT "Vehicles_modelId_fkey" FOREIGN KEY ("modelId") REFERENCES "Models"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vehicles" ADD CONSTRAINT "Vehicles_fuelTypeId_fkey" FOREIGN KEY ("fuelTypeId") REFERENCES "FuelTypes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clients" ADD CONSTRAINT "Clients_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employees" ADD CONSTRAINT "Employees_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inspections" ADD CONSTRAINT "Inspections_vehicleId_fkey" FOREIGN KEY ("vehicleId") REFERENCES "Vehicles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inspections" ADD CONSTRAINT "Inspections_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Clients"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Inspections" ADD CONSTRAINT "Inspections_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "Employees"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rents" ADD CONSTRAINT "Rents_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "Employees"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rents" ADD CONSTRAINT "Rents_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Clients"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
