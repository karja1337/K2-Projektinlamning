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