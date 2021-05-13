const API_KEY = "f6bd687ffa63cd282b6ff2c6877f2669";
const MOVIE_DB_BASE_URL = "api.themoviedb.org";
const MOVIE_DB_IMAGE_URL = "https://image.tmdb.org";

const IMAGE_URL_500 = "$MOVIE_DB_IMAGE_URL/t/p/w500";

const movie_list = {
  "genres": [
    {"id":0,"name":"-"},
    {"id": 28, "name": "Action"},
    {"id": 12, "name": "Adventure"},
    {"id": 16, "name": "Animation"},
    {"id": 35, "name": "Comedy"},
    {"id": 80, "name": "Crime"},
    {"id": 99, "name": "Documentary"},
    {"id": 18, "name": "Drama"},
    {"id": 10751, "name": "Family"},
    {"id": 14, "name": "Fantasy"},
    {"id": 36, "name": "History"},
    {"id": 27, "name": "Horror"},
    {"id": 10402, "name": "Music"},
    {"id": 9648, "name": "Mystery"},
    {"id": 10749, "name": "Romance"},
    {"id": 878, "name": "Science Fiction"},
    {"id": 10770, "name": "TV Movie"},
    {"id": 53, "name": "Thriller"},
    {"id": 10752, "name": "War"},
    {"id": 37, "name": "Western"}
  ]
};

const language = {
  "language": [
    {"code": "fr", "name": "French"},
    {"code": "en-US", "name": "English"},
  ]
};

const categories = {
  "categories": [
    {"category": "popular", "name": "Populaire"},
    {"category": "upcoming", "name": "A venir"},
    {"category": "toprating", "name": "Mieux notés"}
  ]
};

const content = {
  "content": [
    {
      "id": 1,
      "name": "Spécifié",
    },
    {
      "id": 2,
      "name": "Découvrir",
    },
  ]
};

const sort_by = {
  "options": [
    {"id":"none","name":" - "},
    {"id": "release_date.asc", "name": "Date de sortie asc"},
    {"id": "release_date.desc", "name": "Date de sortie desc"},
    {"id": "popularity.asc", "name": "Popularité ascendante"},
    {"id": "popularity.desc", "name": "Popularité décroissante"},
    {"id": "revenue.desc", "name": "Revenue descendante"},
    {"id": "revenue.asc", "name": "Revenue ascendante"},
    {"id": "vote_average.desc", "name": " Vote descendante"},
    {"id": "vote_average.asc", "name": "Vote ascendante"},
  ]
};
