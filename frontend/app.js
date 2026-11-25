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


// close the modal box when the close button is clicked
closeModalBtn.addEventListener('click', function(){
    modal.classList.remove('active');
});

// Function to mount the booking form
function mountBookingForm(eventTitle) {
    const container = document.getElementById('modal-form-container')
    const template = document.getElementById('booking-form-template')
    
    if (!container || !template) 
        return; 

    container.innerHTML = '';
    
    //clone the emlements from the template
    const clone = template.content.cloneNode(true);
    const toggleBtn = clone.querySelector('.toggle-booking-btn');
    const form = clone.querySelector('.card-booking-form');
    const hiddenEventTitle = clone.querySelector('input[name="eventbooking"]');
    const feedback = clone.querySelector('.booking-feedback');
    
    // Sets the hidden input to the eventtitle to display it in the confirmation
    hiddenEventTitle.value = eventTitle;

    // Toggle form visibility when clicking
    toggleBtn.addEventListener('click', () => {

        const isHidden = form.hasAttribute('hidden');

        if (isHidden){
            form.removeAttribute('hidden');
            toggleBtn.setAttribute('aria-expanded', 'true');
            toggleBtn.textContent = 'Avbryt bokning';
        } else {
            form.setAttribute('hidden', '')
            toggleBtn.setAttribute('aria-expanded', 'false');
            toggleBtn.textContent = 'Boka plats';
        }
    });

    // Handle booking submit and confirmation
    form.addEventListener('submit', (e) => {
        e.preventDefault();

        const formData = new FormData(form)
        const bookingData = Object.fromEntries(formData.entries());
        const registrationTime = new Date().toLocaleString();
        const jsonData = JSON.stringify(bookingData);
        console.log('Bokning skickad:', bookingData);
        console.log(jsonData)

        // Present confimation message in feedback paragraph
        if (bookingData.name === "" || bookingData.email === "" || bookingData.phonenumber === "" || bookingData.groupsize === ""){
            feedback.textContent = "Vänligen fyll i namn, email, telefonnummer, evenemang och antal biljetter";
            feedback.classList.add("error");
            feedback.classList.remove("success");
            return;
        }
        if (bookingData.groupsize === "1"){
            feedback.textContent = 
                `Tack för din bokning ${bookingData.name}! 
                Du har bokat ${bookingData.groupsize} plats till ${bookingData.eventbooking}.
                En bekräftelse skickas till ${bookingData.email}.
                Bokning registrerad: ${registrationTime}`;
            feedback.classList.add("success");
            feedback.classList.remove("error");
            return;
        }
        feedback.textContent = 
        `Tack för din bokning ${bookingData.name}! 
        Du har bokat ${bookingData.groupsize} platser till ${bookingData.eventbooking}.
        En bekräftelse skickas till ${bookingData.email}.
        Bokning registrerad: ${registrationTime}`;
        feedback.classList.add("success");
        feedback.classList.remove("error");
        });

        //Clear feedback message if user clicks "Rensa"
        form.addEventListener('reset', () =>{
            feedback.textContent = ''
        })
        // Inject the cloned template into the modal
        container.appendChild(clone)

}

// API-implementation
const apiUrl = "http://localhost:5043/api/events/";
const apiStatus = document.querySelector("#event-list-status");
const apiEventListDiv = document.querySelector(".event-list");
const categoryList = document.querySelector("#category-list");

async function loadEventList() {
    apiStatus.textContent = "Hämtar evenemang...";
    apiEventListDiv.replaceChildren();

    let userMessage = "Evenemangen kunde inte hämtas. Försök igen.";

    try {
        const response = await fetch(apiUrl);

        if (!response.ok) {
            if (response.status === 404) {
                userMessage = "Evenemangen kunde inte hittas.";
            } else if (response.status >= 500 && response.status <= 599) {
                userMessage = "Tjänsten har problem. Försök igen senare.";
            }

            throw new Error(`HTTP-fel: ${response.status}`);
        }

        const events = await response.json();

        if (events.length === 0) {
            apiStatus.textContent = "Inga planerade evenemang hittades.";
            return;
        }  
        for(const event of events){
            const eventCard = document.createElement("article");
            eventCard.classList.add('event-card');
            eventCard.tabIndex = 0;

            const eventImg = document.createElement("img");
            let imgSrc;
            const eventId = event.id;
            switch (eventId) {
                case 1:
                    imgSrc = 'images/kod_tillsammans_cover.jpg';
                    break;
                case 2:
                    imgSrc = 'images/vintermarknad_cover.jpg';
                    break;
                case 3:
                    imgSrc = 'images/springa_park_cover.jpg';
                    break;
                case 4:
                    imgSrc = 'images/sagostund_cover.jpg';
                    break;
            }

            eventImg.setAttribute('src', imgSrc);
            eventImg.classList.add('event-card-img')

            const title = document.createElement("h3");
            title.classList.add('event-card-title');
            title.textContent = event.title;

            const description = document.createElement("p");
            description.classList.add('event-card-desc');
            description.textContent = event.description;

            const date = document.createElement("p");
            date.classList.add('event-card-date');

            const time = document.createElement("p");
            time.classList.add('event-card-time');

            // startsAt format: "2026-00-00T00:00:00+01:00".
            let unformatDateTime = event.startsAt;
            // Splits string at "T", seperating date and time into array.
            const unformatDateTimeArray = unformatDateTime.split("T");

            // Takes out date and shortens time to just 5 characters, "00:00".
            let editDate = unformatDateTimeArray[0];
            let editTime = unformatDateTimeArray[1].substring(0, 5);

            // Adds titles and places in HTML-elements.
            date.textContent = `Datum: ${editDate}`;
            time.textContent = `Starttid: ${editTime}`;

            const location = document.createElement("p");
            location.classList.add('event-card-location');
            location.textContent = `Plats: ${event.venue}`;

            const organizer = document.createElement("p");
            organizer.classList.add('event-card-organizer');
            organizer.textContent = `Arrangör: ${event.organizer}`;

            const category = document.createElement("p");
            category.classList.add('event-card-category');
            category.textContent = event.category;
            
            eventCard.append(eventImg, title, description, date, time, location, organizer, category);
            apiEventListDiv.append(eventCard);
            
        }
        
        const added = new Set();
        categoryList.replaceChildren();

        const defaultOption = document.createElement("option");
        defaultOption.textContent = "Alla kategorier";
        defaultOption.value = "All";
        categoryList.append(defaultOption);

        for (const event of events) {
            if (added.has(event.category)) continue;

            added.add(event.category);

            const item = document.createElement("option");            
            item.textContent = event.category;
            item.value = event.category;          
            categoryList.append(item);
        }

        apiStatus.textContent = `${events.length} evenemang hämtades`;


        const eventCardArray = document.querySelectorAll('.event-card');

        // For each card: Add listener for 'click' or 'Enter', so website can be navigated with Tab-key.
        eventCardArray.forEach(card => {
            card.addEventListener('click', function () {
                fillModalBox(card);
                openModalBox();
            })
            card.addEventListener('keydown', function (event) {
                if (event.key === 'Enter') {
                    fillModalBox(card);
                    openModalBox();
                }
            });
        });

    } catch (error) {
        console.error("Kunde inte hämta evenemang. Se Network för mer information.");
        apiStatus.textContent = userMessage;
    } 
}
    onload = loadEventList()

// Search bar function
const searchBar = document.getElementById('search-bar');
searchBar.addEventListener('input', function() {
    const searchTerm = searchBar.value.toLowerCase();
    const eventCards = document.querySelectorAll('.event-card');

    eventCards.forEach(card => {
        const title = card.querySelector('.event-card-title').textContent.toLowerCase();
        const category = card.querySelector('.event-card-category').textContent.toLowerCase();

        // Hide or show the card based on the search term
        if (title.includes(searchTerm) || category.includes(searchTerm)) {
            card.classList.remove('hidden');
        } else {
            card.classList.add('hidden');
        }

        // Update the status message based on the number of visible cards
        const visibleCards = document.querySelectorAll('.event-card:not(.hidden)');

        if (visibleCards.length === 0) {
            apiStatus.textContent = "Inga evenemang matchar din sökning.";
        } else {
            apiStatus.textContent = `${visibleCards.length} evenemang matchar din sökning.`;
        }
    });
});

categoryList.addEventListener("change", () => {
    const selected = categoryList.value;
     const eventCards = document.querySelectorAll(".event-card");        
        
    eventCards.forEach(card => {
        const eventCategory = card.querySelector(".event-card-category").textContent;
            
        if(selected === eventCategory  || selected === "All") {
        card.classList.remove("hidden");
        }else {
            card.classList.add("hidden");
        }

        const visibleCards = document.querySelectorAll(".event-card:not(.hidden");

        if (visibleCards.length === 0) {
            apiStatus.textContent = "Det finns inga evenemang inom denna kategorin.";
        }else {
            apiStatus.textContent = `${visibleCards.length} Evenemang inom denna kategorin`
        }
    })
});

function openModalBox() {
    //open the modal
    modal.classList.add('active');
    modal.setAttribute('aria-hidden', 'false');
}

function fillModalBox(card) {
    // Get the data from the clicked card
    const img = card.querySelector('.event-card-img').src;
    const title = card.querySelector('.event-card-title').textContent;
    const desc = card.querySelector('.event-card-desc').textContent;
    const date = card.querySelector('.event-card-date').textContent;
    const time = card.querySelector('.event-card-time').textContent;
    const location = card.querySelector('.event-card-location').textContent;
    const organizer = card.querySelector('.event-card-organizer').textContent;
    const category = card.querySelector('.event-card-category').textContent;
    mountBookingForm(title);
    // add modal content
    modalImg.src = img;
    modalTitle.textContent = title;
    modalDesc.textContent = desc;
    modalDate.textContent = date;
    modalTime.textContent = time;
    modalLocation.textContent = location;
    modalOrganizer.textContent = organizer;
    modalCategory.textContent = category;
}
