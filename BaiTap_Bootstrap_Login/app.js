const loginForm = document.querySelector("#login-form");
const passwordInput = document.querySelector("#password");
const passwordToggle = document.querySelector("#toggle-password");
const formMessage = document.querySelector("#form-message");

passwordToggle.addEventListener("click", () => {
    const showPassword = passwordInput.type === "password";
    passwordInput.type = showPassword ? "text" : "password";
    passwordToggle.setAttribute("aria-pressed", String(showPassword));
    passwordToggle.setAttribute("aria-label", showPassword ? "Ẩn mật khẩu" : "Hiện mật khẩu");
});

loginForm.addEventListener("submit", (event) => {
    event.preventDefault();
    loginForm.classList.add("was-validated");
    formMessage.textContent = "";

    if (!loginForm.checkValidity()) {
        loginForm.querySelector(":invalid")?.focus();
        return;
    }

    formMessage.textContent = "Thông tin hợp lệ. Đây là giao diện minh họa, chưa kết nối dịch vụ đăng nhập.";
});
