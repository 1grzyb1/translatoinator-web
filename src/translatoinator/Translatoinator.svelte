<main>
    <Navbar/>
    <div class="flex justify-center h-auto p-20">
        <div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 space-y-5 md:w-1/2 sm:w-full">
            <Combobox list="{languages}"
                      bind:selected={language}/>
            <TextBox label="Phrase to translate"
                     bind:value="{text}"/>
            <NumberInput label="Times to repeat"
                         bind:value={times}/>

            <button class="bg-blue-500 text-white font-bold py-2 px-4 rounded w-full
                           {loading === true ? 'opacity-50 cursor-not-allowed' : ''}"
                    on:click={translate}>
                Translate
            </button>
            {#if (failed)}
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <strong class="font-bold">OMG!</strong>
                    <span class="block sm:inline">Something unimaginable had happened.</span>
                    <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
                        <svg class="fill-current h-6 w-6 text-red-500" role="button"
                             xmlns="http://www.w3.org/2000/svg"
                             viewBox="0 0 20 20"
                             on:click={closeAlert}>
                            <title>Close</title>
                            <path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/>
                        </svg>
                    </span>
                </div>
            {/if}
        </div>
    </div>
</main>

<script>
    import Navbar from "./Navbar.svelte";
    import TextBox from "./TextInput.svelte";
    import NumberInput from "./NumberInput.svelte";
    import {onMount} from 'svelte';
    import Combobox from "./Combobox.svelte";

    export let baseUrl

    let text = '';
    let times = 10;

    let translated
    let languages = {}
    let language = {}

    let loading = false
    let failed = false

    onMount(async () => {
        const res = await fetch(baseUrl + '/randomTranslate');
        languages = await res.json();
        language = languages.find(element => element.code === 'en')
        console.log(languages)
    });

    async function translate() {
        console.log(language)
        loading = true
        if (times > 10)
            return
        const res = await fetch(baseUrl + '/randomTranslate', {
            method: 'POST',
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({
                word: text,
                repeat: times,
                // inputLanguageCode: language.code
            })
        })
        translated = await res.json()
        failed = res.status !== 200
        loading = false
        console.log(translated)
    }

    function closeAlert() {
        failed = false
    }
</script>