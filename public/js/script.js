// General scripts for the application

// Initialize tooltips
document.addEventListener('DOMContentLoaded', function() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Form validation for registration
    const registerForm = document.getElementById('registerForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            
            if (password.value !== confirmPassword.value) {
                e.preventDefault();
                alert('Passwords do not match!');
                confirmPassword.focus();
            }
        });
    }
    
    // Auto-fill today's date for booking
    const bookingDate = document.getElementById('bookingDate');
    if (bookingDate) {
        const now = new Date();
        // Set min date to today
        const minDate = now.toISOString().slice(0, 16);
        bookingDate.min = minDate;
        
        // Set default to tomorrow at 9 AM
        now.setDate(now.getDate() + 1);
        now.setHours(9, 0, 0, 0);
        const defaultDate = now.toISOString().slice(0, 16);
        bookingDate.value = defaultDate;
    }
});

// Handle booking modal
function setupBookingModal() {
    const bookTestButtons = document.querySelectorAll('.book-test');
    const bookingModal = new bootstrap.Modal(document.getElementById('bookingModal'));
    const modalTestName = document.getElementById('modalTestName');
    const testIdInput = document.getElementById('testId');
    const testNameInput = document.getElementById('testName');
    
    bookTestButtons.forEach(button => {
        button.addEventListener('click', function() {
            const testId = this.getAttribute('data-test-id');
            const testName = this.getAttribute('data-test-name');
            
            modalTestName.textContent = testName;
            testIdInput.value = testId;
            testNameInput.value = testName;
            
            bookingModal.show();
        });
    });
}

// Initialize booking modal if on services page
if (document.querySelector('.book-test')) {
    setupBookingModal();
}