<script setup lang="ts">
const router = useRouter();

const inventoryExpanded = ref(false);
const adminExpanded = ref(false);

// const isSignedIn = router.
// $cookies.get("user_token") !== undefined;

const activeRoute = router.currentRoute.value;
</script>

<template>
  <ul class="flex flex-col gap-2">
    <li>
      <NuxtLink class="font-medium" to="/"> Dashboard </NuxtLink>
    </li>
    <li>
      <NuxtLink class="font-medium" to="/rents"> Rentas </NuxtLink>
    </li>
    <li
      class="accordion"
      :class="{
        active: inventoryExpanded || activeRoute.path.startsWith('/inventory'),
      }"
      @click="inventoryExpanded = !inventoryExpanded"
    >
      <a href="#" class="font-medium"> Inventario </a>
      <ul class="hidden">
        <li>
          <NuxtLink to="/inventory/fuelTypes"> Tipos de combustible </NuxtLink>
        </li>
        <li>
          <NuxtLink to="/inventory/vehicle-types">
            Tipos de vehiculos
          </NuxtLink>
        </li>
        <li>
          <NuxtLink to="/inventory/makes"> Marcas </NuxtLink>
        </li>
        <li>
          <NuxtLink to="/inventory/models"> Modelos </NuxtLink>
        </li>
        <li>
          <NuxtLink to="/inventory/vehicles"> Vehiculos </NuxtLink>
        </li>
      </ul>
    </li>

    <li v-if="true">
      <a href="#" class="font-medium" @click="adminExpanded = !adminExpanded">
        Admin
      </a>
      <ul class="hidden" v-if="adminExpanded">
        <li>
          <NuxtLink to="/admin/profile"> Mi perfil </NuxtLink>
        </li>
        <li>
          <NuxtLink to="/admin/employees"> Empleados </NuxtLink>
        </li>
        <li>
          <NuxtLink to="/admin/clients"> Clientes </NuxtLink>
        </li>
      </ul>
    </li>

    <li>
      <NuxtLink class="font-medium" to="/logout"> Cerrar sesion </NuxtLink>
    </li>
  </ul>
</template>

<style lang="scss">
.accordion {
  cursor: pointer;
}

.accordion:hover {
  background-color: #f5f5f5;
}

.accordion .hidden {
  display: none;
}

.accordion.active .hidden {
  display: block;
}
</style>
