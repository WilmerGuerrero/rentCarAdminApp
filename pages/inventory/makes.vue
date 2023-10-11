<script setup lang="ts">
import { Makes } from "@prisma/client";
import { DynamicFormInput } from "~/typings/dynamicFormInput";
import { BaseInventoryFields } from "~/typings/baseInventoryFields";

const showFormModal = ref(false);
const formBody = ref({});
const inputFields: DynamicFormInput[] = [
  {
    key: "id",
    type: "number",
    label: "Identificador",
    required: true,
    hidden: true,
  },
  {
    key: "name",
    type: "text",
    label: "Marca",
    required: true,
  },
  {
    key: "description",
    type: "textarea",
    label: "Descripcion",
    required: true,
  },
  {
    key: "actions",
    type: "button",
    label: "",
    required: true,
  },
];

const tableColumns: { key: string; label: string }[] = [
  { key: "id", label: "Identificador" },
  { key: "name", label: "Marca" },
  { key: "description", label: "Descripcion" },
  { key: "status", label: "Estatus" },
];
const get = await useFetch("/api/makes/get");

const onDelete = async (id: number) => {
  const { pending, status } = await useFetch(`/api/makes/${id}`, {
    method: "DELETE",
  });
  console.log("delete", pending.value, status.value);
  await get.refresh();
  console.log("get data", get.data.value);
  return { pending, status };
};

const onSubmit = async (formData: BaseInventoryFields) => {
  console.log("form", formData);
  await $fetch<Makes>("/api/makes/put", {
    method: "PUT",
    body: JSON.stringify(formData),
  });
  await get.refresh();
};

const onModify = async (formData: BaseInventoryFields) => {
  formBody.value = formData;
  showFormModal.value = !showFormModal.value;
};
</script>

<template>
  <button
    class="block text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
    type="button"
    @click="showFormModal = !showFormModal"
  >
    Crear nuevo
  </button>
  <div
    v-if="showFormModal"
    aria-hidden="true"
    class="fixed top-0 left-0 right-0 z-50 w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full"
  >
    <div class="relative w-full max-w-md max-h-full">
      <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
        <button
          type="button"
          class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ml-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
          @click="showFormModal = !showFormModal"
        >
          <svg
            class="w-3 h-3"
            aria-hidden="true"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 14 14"
          >
            <path
              stroke="currentColor"
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"
            />
          </svg>
          <span class="sr-only" @click="showFormModal = !showFormModal"
            >Cerrar modal</span
          >
        </button>
        <dynamic-form
          :input-fields="inputFields"
          :form-data="formBody"
          @submit="onSubmit($event)"
        ></dynamic-form>
      </div>
    </div>
  </div>
  <dynamic-table
    :columns="tableColumns"
    :data="get.data.value || []"
    @delete-row="onDelete($event)"
    @modify-row="onModify($event)"
  >
  </dynamic-table>
</template>
