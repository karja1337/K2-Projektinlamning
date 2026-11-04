// modal functionality
const modal = document.getElementById('event-modal');
const modalImg = document.getElementById('modal-img');
const modalTitle = document.getElementById('modal-title');
const modalDesc = document.getElementById('modal-desc');
const modalDate = document.getElementById('modal-date');
const modalTime = document.getElementById('modal-time');
const closeModalBtn = document.getElementById('modal-close-btn');

document.querySelectorAll('.event-card').forEach(card =>{
    card.addEventListener('click', function(){
        // Get the data from the clicked card
        const img = card.querySelector('.event-card-img').src;
        const title = card.querySelector('.event-card-title').textContent;
        const desc = card.querySelector('.event-card-desc').textContent;
        const date = card.querySelector('.event-card-date').textContent;
        const time = card.querySelector('.event-card-time').textContent;

        // add modal content
        modalImg.src = img;
        modalTitle.textContent = title;
        modalDesc.textContent = desc;
        modalDate.textContent = date;
        modalTime.textContent = time;

        //open the modal
        modal.classList.add('active');
        modal.setAttribute('aria-hidden', 'false');
    });
});

// Form functionality

//variables from selected query

const form = document.querySelector("#booking");
const nameInput = document.querySelector("#name");
const emailInput = document.querySelector("#email");
const phonenumberInput= document.querySelector("#phonenumber");
const eventSelect = document.querySelector("#eventbooking");
const groupsizeSelect = document.querySelector("#groupsize");

//feedback-paragraph for input validation/error
const feedback = document.querySelector("#booking-feedback");



form.addEventListener("submit", booking => {
  booking.preventDefault();
    const name = nameInput.value.trim();
    const email = emailInput.value.trim();
    const phonenumber = phonenumberInput.value.trim();
    const event = eventSelect.value;
    const groupsize = groupsizeSelect.value;
    
    //Test in console
    console.log(name);
    console.log(email);
    console.log(phonenumber);
    console.log(event);
    console.log(groupsize);
    return;
    
});


// koppla app.js med defer --klart--

//  Välj DOM-element --klart--

// kontrollera referenserna i Console --klart--

// lyssna på formulärets submit --klart--

// stoppa omladdning --klart--

// läs och normalisera värden --klart--

// validera

// visa fel eller bekräftelse

// uppdatera CSS-klasser

// testa efter varje steg
