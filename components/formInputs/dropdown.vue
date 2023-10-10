<script setup lang="ts">
defineProps({
    isRequired: Boolean,
    nonValueLabel: String,
    key: String,
    options: {
        type: Array<{ label: string, value: number }>,
        required: true
    }
})

const emits = defineEmits(['change']);

const onChange = (newValue: string | number) => {
    emits('change', newValue);
}

let selectedOption = ''
</script>

<template>
    <select 
        :class="{ 
            'form-select': true, 
            'w-full': true, 
            'is-required': isRequired }" 
        v-model="selectedOption"
        @change="onChange(selectedOption)"
    >
    <option value=""> {{ nonValueLabel }}</option>
    <template 
        v-for="(option, value) in options"
        :key="`${key}-${value}`"
    >
        <option :value="value">{{ option }}</option>
      </template>
    </select>
  </template>
  
  