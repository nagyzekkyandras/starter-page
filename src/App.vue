<template>
  <div>
    <h1 class="page-title">{{ title }}</h1>

    <div class="search-container">
      <input
        v-model="searchQuery"
        type="text"
        placeholder="Search links..."
        class="search-bar"
      />
    </div>

    <div v-for="(items, group) in filteredGroupedLinks" :key="group">
      <h2 class="group-title">{{ group }}</h2>
      <div class="grid">
        <div v-for="item in items" :key="item.link" class="card">
          <a :href="item.link" target="_blank">
            <img :src="item.icon_url" alt="Icon">
            <p>{{ item.description }}</p>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import links from './assets/links.json'

export default {
  data() {
    return {
      searchQuery: '',
      links: links,
      title: "Link collection"
    }
  },
  computed: {
    groupedLinks() {
      const groups = {}
      this.links.forEach(link => {
        if (!groups[link.group]) {
          groups[link.group] = []
        }
        groups[link.group].push(link)
      })
      return groups
    },
    filteredGroupedLinks() {
      const query = this.searchQuery.toLowerCase()

      const filtered = {}

      for (const [group, items] of Object.entries(this.groupedLinks)) {
        const matchingItems = items.filter(item =>
          item.description.toLowerCase().includes(query) ||
          item.link.toLowerCase().includes(query)
        )

        if (matchingItems.length > 0) {
          filtered[group] = matchingItems
        }
      }

      return filtered
    }
  }
}
</script>

<style scoped>
@import './assets/styles.css';
</style>
