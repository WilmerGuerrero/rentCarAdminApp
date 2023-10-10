<script setup>

defineProps({
    isRequired: Boolean,
    model: {
        type: Number,
        required: isRequired
    }
})

</script>

<template>
    <input 
        type="number"
        :class="{ 'form-input': true, 'w-full': true }" 
        v-model="model"
        :required="isRequired"
    />
  </template>
  