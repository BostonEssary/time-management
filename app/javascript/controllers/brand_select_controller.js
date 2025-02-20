import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="brand-select"
export default class extends Controller {
  static targets = ['results', 'search', 'hiddenField']
  connect() {
    console.log('Brand Select Controller')
    this.timer = null;
  }

  async getBrands(query) {
    if (query.length === 0) {
      this.clearResponses()
      return
    }
    const response = await get(`/api/brands.json?query=${query}`, {
      contentType: 'application/json'
    })
    if (response.ok) {
      const body = await response.json
      return body
    }
  }

  search(event) {
    let query = event.target.value
    clearTimeout(this.timer)
    if (query.length === 0){
      this.clearResponses()
      return
    }

    this.timer = setTimeout(async () => {
      console.log('I have now searched')
      const brands = await this.getBrands(query)
      this.appendResults(brands)
    }, 300);
  }

  appendResults(brands) {
    const newDiv = document.createElement('div')
    brands.forEach(brand => {
     newDiv.insertAdjacentHTML('beforeend', this.resultRow(brand.name, brand.id))
    });
    this.resultsTarget.innerHTML = ''
    this.resultsTarget.classList.remove('hidden')
    this.resultsTarget.append(newDiv)
  }

  clearResponses(){
    this.resultsTarget.innerHTML = ''
    this.resultsTarget.classList.add('hidden')
  }

  setBrand(event){
    console.log('Brand Set!')
    this.searchTarget.value = event.target.innerText
    this.hiddenFieldTarget.value = event.target.dataset.brandId
    this.resultsTarget.classList.add('hidden')

  }


  resultRow(name, id){
    return `
      <div class='p-2 hover:bg-blue-300' data-action='click->brand-select#setBrand' data-brand-id='${id}' >
        ${name}
      </div>
      `
  }

}
