<template>
    <div class="flex flex-col">
      <Header />
      <div class="flex flex-row">
        <side-bar />
        <main class="flex-1 p-4">
          weo
          <slot></slot>
        </main>
      </div>
    </div>
</template>

<style scoped>

main {
  top: 5rem;
  left: 10rem;
}

</style>
