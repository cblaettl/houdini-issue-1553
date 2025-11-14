<script lang="ts">
  import { type PageData } from "./$houdini";

  interface Props {
    data: PageData;
  }

  let { data }: Props = $props();
  let result = $derived(data.InvoicesOverview);
  let invoices = $derived($result.data?.invoices);
</script>

{#each invoices as invoice}
  <div>Invoice: {invoice.name}</div>
{/each}