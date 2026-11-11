// modal functionality
const modal = document.getElementById('event-modal');
const modalImg = document.getElementById('modal-img');
const modalTitle = document.getElementById('modal-title');
const modalDesc = document.getElementById('modal-desc');
const modalDate = document.getElementById('modal-date');
const modalTime = document.getElementById('modal-time');
const modalLocation = document.getElementById('modal-location');
const modalOrganizer = document.getElementById('modal-organizer');
const closeModalBtn = document.getElementById('modal-close-btn');
const modalCategory = document.getElementById('modal-category');

// forEach loop to add click event listener to each event card
document.querySelectorAll('.event-card').forEach(card =>{
    card.addEventListener('click', function(){
        // Get the data from the clicked card
        const img = card.querySelector('.event-card-img').src;
        const title = card.querySelector('.event-card-title').textContent;
        const desc = card.querySelector('.event-card-desc').textContent;
        const date = card.querySelector('.event-card-date').textContent;
        const time = card.querySelector('.event-card-time').textContent;
        const location = card.querySelector('.event-card-location').textContent;
        const organizer = card.querySelector('.event-card-organizer').textContent;
        const category = card.querySelector('.event-card-category').textContent;

        // add modal content
        modalImg.src = img;
        modalTitle.textContent = title;
        modalDesc.textContent = desc;
        modalDate.textContent = date;
        modalTime.textContent = time;
        modalLocation.textContent = location;
        modalOrganizer.textContent = organizer;
        modalCategory.textContent = category;

        //open the modal
        modal.classList.add('active');
        modal.setAttribute('aria-hidden', 'false');
    });
});

// booking form variables
const bookingBtn = document.getElementById('booking-btn');
const bookingForm = document.getElementById('booking-form');
// close the modal box when the close button is clicked
closeModalBtn.addEventListener('click', function(){
    modal.classList.remove('active');
    bookingForm.classList.remove('active');
    bookingBtn.style.display = 'block';
});

// open the booking form when the booking button is clicked

bookingBtn.addEventListener('click', function(){
    bookingForm.classList.add('active');
    
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
    const registrationTime = new Date().toLocaleString(); // Get the current date and time
    
    if (name === "" || email === "" || phonenumber === "" || event === "" || groupsize === "") {
        feedback.textContent = "Vänligen fyll i namn, email, telefonnummer, evenemang och antal biljetter";
        feedback.classList.add("error");
        feedback.classList.remove("success");
        return;
    }
    //Här kommer bekräftelsen
    if (groupsize === "1"){
    feedback.textContent = 
       `Tack för din bokning ${name}! 
       Du har bokat ${groupsize} plats till ${event}.
       En bekräftelse skickas till ${email}.
       Bokning registrerad: ${registrationTime}`;
       feedback.classList.add("success");
        feedback.classList.remove("error");
       return;
    }    
    feedback.textContent = 
    `Tack för din bokning ${name}! 
    Du har bokat ${groupsize} platser till ${event}.
    En bekräftelse skickas till ${email}.
    Bokning registrerad: ${registrationTime}`;
    feedback.classList.add("success");
    feedback.classList.remove("error");
});


// koppla app.js med defer --klart--

//  Välj DOM-element --klart--

// kontrollera referenserna i Console --klart--

// lyssna på formulärets submit --klart--

// stoppa omladdning --klart--

// läs och normalisera värden --klart--

// validera --klart--

// visa fel eller bekräftelse --klart--

// uppdatera CSS-klasser --klart--

// testa efter varje steg --klart--

