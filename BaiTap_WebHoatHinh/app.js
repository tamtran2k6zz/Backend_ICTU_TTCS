const movies = [
    {
        id: "big-buck-bunny",
        title: "Big Buck Bunny",
        year: 2008,
        runtime: "12 phút",
        audio: "Không thoại",
        quality: "1080p",
        category: "PHIÊU LƯU · HOẠT HÌNH 3D",
        description: "Chú thỏ to lớn hiền lành bắt đầu một ngày bình yên trong khu rừng. Một phim ngắn vui nhộn về tình bạn và lòng tốt.",
        playback: "video",
        src: "https://storage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        embed: "",
        posterClass: "poster-bunny",
        posterText: "BIG<br>BUCK<br>BUNNY",
        views: 12800,
        addedAt: "2026-10-14",
    },
    {
        id: "caminandes-gran-dillama",
        title: "Caminandes: Gran Dillama",
        year: 2013,
        runtime: "3 phút",
        audio: "Không thoại",
        quality: "1080p",
        category: "PHIÊU LƯU · HOẠT HÌNH 3D",
        description: "Chú lạc đà không bướu Koro tìm cách vượt qua con đường đầy thử thách trong chuyến phiêu lưu ngắn giữa vùng Patagonia.",
        playback: "youtube",
        src: "",
        embed: "https://www.youtube-nocookie.com/embed/Z4C82eyhwgU?rel=0&modestbranding=1",
        posterClass: "poster-caminandes",
        posterText: "CAMINANDES<br>GRAN DILLAMA",
        views: 8900,
        addedAt: "2026-10-12",
    },
];

const movieList = document.querySelector("#movie-list");
const recommendationList = document.querySelector("#recommendation-list");
const resultCount = document.querySelector("#result-count");
const movieSearch = document.querySelector("#movie-search");
const headerSearch = document.querySelector("#header-search");
const videoPlayer = document.querySelector("#movie-player");
const videoSource = videoPlayer.querySelector("source");
const youtubePlayer = document.querySelector("#youtube-player");
const sortButtons = [...document.querySelectorAll(".sort-button")];

let activeMovieId = movies[0].id;
let activeSort = "popular";
let visibleMovies = [...movies];

function createPoster(movie) {
    const poster = document.createElement("span");
    poster.className = `movie-poster ${movie.posterClass}`;
    poster.setAttribute("aria-hidden", "true");

    const illustration = document.createElement("i");
    const label = document.createElement("b");
    label.innerHTML = movie.posterText;
    poster.append(illustration, label);
    return poster;
}

function createMovieItem(movie, recommendation = false) {
    const button = document.createElement("button");
    button.type = "button";
    button.className = recommendation ? "recommendation-card" : "movie-item";
    button.dataset.movieId = movie.id;

    if (!recommendation && movie.id === activeMovieId) {
        button.classList.add("active");
        button.setAttribute("aria-pressed", "true");
    } else if (!recommendation) {
        button.setAttribute("aria-pressed", "false");
    }

    button.append(createPoster(movie));

    if (recommendation) {
        const details = document.createElement("span");
        const title = document.createElement("strong");
        const description = document.createElement("small");
        title.textContent = movie.title;
        description.textContent = `${movie.runtime} · ${movie.quality.toUpperCase()}`;
        details.append(title, description);
        button.append(details);
    } else {
        const info = document.createElement("span");
        info.className = "movie-info";

        const title = document.createElement("strong");
        const metadata = document.createElement("small");
        const tags = document.createElement("span");
        const quality = document.createElement("em");
        const age = document.createElement("em");
        const play = document.createElement("span");

        title.textContent = movie.title;
        metadata.textContent = `${movie.runtime} · ${movie.audio}`;
        tags.className = "movie-tags";
        quality.textContent = movie.quality.toUpperCase();
        age.textContent = "3+";
        tags.append(quality, age);
        info.append(title, metadata, tags);
        play.className = "play-indicator";
        play.setAttribute("aria-hidden", "true");
        play.textContent = "▶";
        button.append(info, play);
    }

    button.addEventListener("click", () => selectMovie(movie));
    return button;
}

function sortMovies(list) {
    return [...list].sort((a, b) => activeSort === "popular"
        ? b.views - a.views
        : new Date(b.addedAt) - new Date(a.addedAt));
}

function renderMovies() {
    const query = movieSearch.value.trim().toLocaleLowerCase("vi-VN");
    visibleMovies = sortMovies(movies.filter((movie) => movie.title.toLocaleLowerCase("vi-VN").includes(query)));
    movieList.replaceChildren();
    recommendationList.replaceChildren();
    resultCount.textContent = `${visibleMovies.length} phim`;

    if (visibleMovies.length === 0) {
        const empty = document.createElement("p");
        empty.className = "empty-state";
        empty.textContent = "Chưa tìm thấy phim phù hợp.";
        movieList.append(empty);
        recommendationList.append(empty.cloneNode(true));
        return;
    }

    for (const movie of visibleMovies) {
        movieList.append(createMovieItem(movie));
    }

    for (const movie of visibleMovies.filter((item) => item.id !== activeMovieId)) {
        recommendationList.append(createMovieItem(movie, true));
    }

    if (visibleMovies.length === 1) {
        const only = document.createElement("p");
        only.className = "empty-state";
        only.textContent = "Không có phim khác trong kết quả.";
        recommendationList.append(only);
    }
}

function selectMovie(movie) {
    activeMovieId = movie.id;
    document.querySelector("#movie-title").textContent = movie.title;
    document.querySelector("#movie-category").textContent = movie.category;
    document.querySelector("#movie-description").textContent = movie.description;
    document.querySelector("#movie-metadata").replaceChildren(
        ...[String(movie.year), movie.runtime, movie.audio, movie.quality].map((label) => {
            const item = document.createElement("span");
            item.textContent = label;
            return item;
        }),
    );

    videoPlayer.pause();
    youtubePlayer.removeAttribute("src");

    if (movie.playback === "youtube") {
        videoPlayer.hidden = true;
        youtubePlayer.hidden = false;
        youtubePlayer.title = `YouTube: ${movie.title}`;
        youtubePlayer.src = movie.embed;
    } else {
        youtubePlayer.hidden = true;
        videoPlayer.hidden = false;
        videoPlayer.setAttribute("aria-label", `Trình phát phim ${movie.title}`);
        videoSource.src = movie.src;
        videoPlayer.load();
    }

    renderMovies();
}

for (const button of sortButtons) {
    button.addEventListener("click", () => {
        activeSort = button.dataset.sort;
        for (const option of sortButtons) {
            const selected = option === button;
            option.classList.toggle("active", selected);
            option.setAttribute("aria-pressed", String(selected));
        }
        renderMovies();
    });
}

for (const link of document.querySelectorAll('.head-links a[href="#moi-cap-nhat"], .head-links a[href="#xem-nhieu"]')) {
    link.addEventListener("click", (event) => {
        event.preventDefault();
        document.querySelector(link.getAttribute("href")).click();
        document.querySelectorAll(".head-links a").forEach((item) => item.classList.remove("active"));
        link.classList.add("active");
    });
}

movieSearch.addEventListener("input", () => {
    headerSearch.value = movieSearch.value;
    renderMovies();
});
headerSearch.addEventListener("input", () => {
    movieSearch.value = headerSearch.value;
    renderMovies();
});

document.addEventListener("keydown", (event) => {
    if ((event.metaKey || event.ctrlKey) && event.key.toLowerCase() === "k") {
        event.preventDefault();
        headerSearch.focus();
    }
});

renderMovies();
selectMovie(movies[0]);
