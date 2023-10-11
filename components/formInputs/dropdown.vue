<script setup lang="ts">
import { DynamicFormInput } from "~/typings/dynamicFormInput";

const emits = defineEmits(["onChange"]);

defineProps({
  inputField: {} as any,
});

const inputData: { [key: string]: string } = reactive({});

const onChange = (prop: string) => {
  console.log("dropdownchange", prop, inputData[prop]);

  emits("onChange", inputData[prop]);
};
</script>

<template>
  <select
    :id="inputField.key"
    v-model="inputData[inputField.key]"
    :required="inputField.required"
    :values="inputField.values"
    @change="onChange(inputField.key)"
    class="mb-4"
  >
    <option value="">Seleccione una opcion:</option>

    <option
      v-for="option in inputField.values"
      :key="option.id"
      :value="option.id"
    >
      {{ option.name }}
    </option>
  </select>
</template>
