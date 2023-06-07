/*
const List<Map<String, dynamic>> COUNTRIES = [
  {
    "country": "United States",
    "code": "US",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Canada",
    "code": "CA",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Austria",
    "code": "AT",
    "dial_code": "+43",
    "phLength": 10
  },
  {
    "country": "Australia",
    "code": "AU",
    "dial_code": "+61",
    "phLength": 9
  },
  {
    "country": "Belgium",
    "code": "BE",
    "dial_code": "+32",
    "phLength": 9
  },
  {
    "country": "Switzerland",
    "code": "CH",
    "dial_code": "+41",
    "phLength": 9
  },
  {
    "country": "Germany",
    "code": "DE",
    "dial_code": "+49",
    "phLength": 10
  },
  {
    "country": "Denmark",
    "code": "DK",
    "dial_code": "+45",
    "phLength": 8
  },
  {
    "country": "Spain",
    "code": "ES",
    "dial_code": "+34",
    "phLength": 9
  },
  {
    "country": "United Kingdom",
    "code": "GB",
    "dial_code": "+44",
    "phLength": 10
  },
  {
    "country": "Hong Kong",
    "code": "HK",
    "dial_code": "+852",
    "phLength": 8
  },
  {
    "country": "Ireland",
    "code": "IE",
    "dial_code": "+353",
    "phLength": 9
  },
  {
    "country": "Italy",
    "code": "IT",
    "dial_code": "+39",
    "phLength": 10
  },
  {
    "country": "Japan",
    "code": "JP",
    "dial_code": "+81",
    "phLength": 10
  },
  {
    "country": "Luxembourg",
    "code": "LU",
    "dial_code": "+352",
    "phLength": 9
  },
  {
    "country": "Netherlands",
    "code": "NL",
    "dial_code": "+31",
    "phLength": 9
  },
  {
    "country": "Norway",
    "code": "NO",
    "dial_code": "+47",
    "phLength": 8
  },
  {
    "country": "New Zealand",
    "code": "NZ",
    "dial_code": "+64",
    "phLength": 9
  },
  {
    "country": "Portugal",
    "code": "PT",
    "dial_code": "+63",
    "phLength": 9
  },
  {
    "country": "Sweden",
    "code": "SE",
    "dial_code": "+46",
    "phLength": 7
  },
  {
    "country": "Singapore",
    "code": "SG",
    "dial_code": "+65",
    "phLength": 8
  },
  {
    "country": "Afghanistan",
    "code": "AF",
    "dial_code": "+93",
    "phLength": 9
  },
  {
    "country": "Algeria",
    "code": "DZ",
    "dial_code": "+213",
    "phLength": 9
  },
  {
    "country": "American Samoa",
    "code": "AS",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Anguilla",
    "code": "AI",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Armenia",
    "code": "AM",
    "dial_code": "+374",
    "phLength": 8
  },
  {
    "country": "Aruba",
    "code": "AW",
    "dial_code": "+297",
    "phLength": 7
  },
  {
    "country": "Azerbaijan",
    "code": "AZ",
    "dial_code": "+994",
    "phLength": 9
  },
  {
    "country": "Bahamas",
    "code": "BS",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Bahrain",
    "code": "BH",
    "dial_code": "+973",
    "phLength": 8
  },
  {
    "country": "Bangladesh",
    "code": "BD",
    "dial_code": "+880",
    "phLength": 10
  },
  {
    "country": "Barbados",
    "code": "BB",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Belarus",
    "code": "BY",
    "dial_code": "+375",
    "phLength": 9
  },
  {
    "country": "Belize",
    "code": "BZ",
    "dial_code": "+501",
    "phLength": 7
  },
  {
    "country": "Benin",
    "code": "BJ",
    "dial_code": "+229",
    "phLength": 9
  },
  {
    "country": "Bermuda",
    "code": "BM",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Bosnia and Herzegovina",
    "code": "BA",
    "dial_code": "+387",
    "phLength": 8
  },
  {
    "country": "Brazil",
    "code": "BR",
    "dial_code": "+55",
    "phLength": 11
  },
  {
    "country": "Burkina Faso",
    "code": "BF",
    "dial_code": "+226",
    "phLength": 8
  },
  {
    "country": "Cambodia",
    "code": "KH",
    "dial_code": "+855",
    "phLength": 9
  },
  {
    "country": "Cameroon",
    "code": "CM",
    "dial_code": "+237",
    "phLength": 9
  },
  {
    "country": "Cayman Islands",
    "code": "KY",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Chad",
    "code": "TD",
    "dial_code": "+235",
    "phLength": 8
  },
  {
    "country": "Chile",
    "code": "CL",
    "dial_code": "+56",
    "phLength": 9
  },
  {
    "country": "China",
    "code": "CN",
    "dial_code": "+86",
    "phLength": 13
  },
  {
    "country": "Colombia",
    "code": "CO",
    "dial_code": "+57",
    "phLength": 10
  },
  {
    "country": "Cook Islands",
    "code": "CK",
    "dial_code": "+682",
    "phLength": 5
  },
  {
    "country": "Costa Rica",
    "code": "CR",
    "dial_code": "+506",
    "phLength": 8
  },
  {
    "country": "Croatia",
    "code": "HR",
    "dial_code": "+385",
    "phLength": 9
  },
  {
    "country": "Cyprus",
    "code": "CY",
    "dial_code": "+357",
    "phLength": 8
  },
  {
    "country": "Czech Republic",
    "code": "CZ",
    "dial_code": "+420",
    "phLength": 9
  },
  {
    "country": "Dominica",
    "code": "DM",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Dominican Republic",
    "code": "DO",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Ecuador",
    "code": "EC",
    "dial_code": "+593",
    "phLength": 9
  },
  {
    "country": "Egypt",
    "code": "EG",
    "dial_code": "+20",
    "phLength": 10
  },
  {
    "country": "El Salvador",
    "code": "SV",
    "dial_code": "+503",
    "phLength": 8
  },
  {
    "country": "Estonia",
    "code": "EE",
    "dial_code": "+372",
    "phLength": 8
  },
  {
    "country": "Faroe Islands",
    "code": "FO",
    "dial_code": "+298",
    "phLength": 5
  },
  {
    "country": "French Guiana",
    "code": "GF",
    "dial_code": "+594",
    "phLength": 9
  },
  {
    "country": "French Polynesia",
    "code": "PF",
    "dial_code": "+689",
    "phLength": 6
  },
  {
    "country": "Brazil",
    "code": "BR",
    "dial_code": "+55",
    "phLength": 11
  },
  {
    "country": "Gabon",
    "code": "GA",
    "dial_code": "+241",
    "phLength": 7
  },
  {
    "country": "Georgia",
    "code": "GE",
    "dial_code": "+995",
    "phLength": 9
  },
  {
    "country": "Ghana",
    "code": "GH",
    "dial_code": "+233",
    "phLength": 9
  },
  {
    "country": "Greece",
    "code": "GR",
    "dial_code": "+30",
    "phLength": 10
  },
  {
    "country": "Greenland",
    "code": "GL",
    "dial_code": "+299",
    "phLength": 6
  },
  {
    "country": "Grenada",
    "code": "GD",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Guadeloupe",
    "code": "GP",
    "dial_code": "+590",
    "phLength": 9
  },
  {
    "country": "Guam",
    "code": "GU",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Guatemala",
    "code": "GT",
    "dial_code": "+502",
    "phLength": 8
  },
  {
    "country": "Guernsey",
    "code": "GG",
    "dial_code": "+44",
    "phLength": 10
  },
  {
    "country": "Honduras",
    "code": "HN",
    "dial_code": "+504",
    "phLength": 8
  },
  {
    "country": "Hungary",
    "code": "HU",
    "dial_code": "+36",
    "phLength": 9
  },
  {
    "country": "India",
    "code": "IN",
    "dial_code": "+91",
    "phLength": 10
  },
  {
    "country": "Indonesia",
    "code": "ID",
    "dial_code": "+62",
    "phLength": 9
  },
  {
    "country": "Iran",
    "code": "IR",
    "dial_code": "+98",
    "phLength": 10
  },
  {
    "country": "Israel",
    "code": "IL",
    "dial_code": "+972",
    "phLength": 9
  },
  {
    "country": "Jamaica",
    "code": "JM",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Jordan",
    "code": "JO",
    "dial_code": "+962",
    "phLength": 9
  },
  {
    "country": "Kazakhstan",
    "code": "KZ",
    "dial_code": "+7",
    "phLength": 10
  },
  {
    "country": "Kenya",
    "code": "KE",
    "dial_code": "+254",
    "phLength": 10
  },
  {
    "country": "Kiribati",
    "code": "KI",
    "dial_code": "+686",
    "phLength": 8
  },
  {
    "country": "Kuwait",
    "code": "KW",
    "dial_code": "+965",
    "phLength": 8
  },
  {
    "country": "Latvia",
    "code": "LV",
    "dial_code": "+371",
    "phLength": 8
  },
  {
    "country": "Lebanon",
    "code": "LB",
    "dial_code": "+961",
    "phLength": 7
  },
  {
    "country": "Liberia",
    "code": "LR",
    "dial_code": "+231",
    "phLength": 7
  },
  {
    "country": "Lithuania",
    "code": "LT",
    "dial_code": "+370",
    "phLength": 8
  },
  {
    "country": "Malaysia",
    "code": "MY",
    "dial_code": "+60",
    "phLength": 7
  },
  {
    "country": "Maldives",
    "code": "MV",
    "dial_code": "+960",
    "phLength": 7
  },
  {
    "country": "Mali",
    "code": "ML",
    "dial_code": "+223",
    "phLength": 8
  },
  {
    "country": "Malta",
    "code": "MT",
    "dial_code": "+356",
    "phLength": 8
  },
  {
    "country": "Marshall Islands",
    "code": "MH",
    "dial_code": "+692",
    "phLength": 7
  },
  {
    "country": "Martinique",
    "code": "MQ",
    "dial_code": "+596",
    "phLength": 9
  },
  {
    "country": "Mauritius",
    "code": "MU",
    "dial_code": "+230",
    "phLength": 8
  },
  {
    "country": "Mexico",
    "code": "MX",
    "dial_code": "+52",
    "phLength": 10
  },
  {
    "country": "Moldova",
    "code": "MD",
    "dial_code": "+373",
    "phLength": 8
  },
  {
    "country": "Montenegro",
    "code": "ME",
    "dial_code": "+382",
    "phLength": 8
  },
  {
    "country": "Montserrat",
    "code": "MS",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Mozambique",
    "code": "MZ",
    "dial_code": "+258",
    "phLength": 12
  },
  {
    "country": "Myanmar",
    "code": "MM",
    "dial_code": "+95",
    "phLength": 8
  },
  {
    "country": "Nepal",
    "code": "NP",
    "dial_code": "+977",
    "phLength": 10
  },
  {
    "country": "New Caledonia",
    "code": "NC",
    "dial_code": "+687",
    "phLength": 6
  },
  {
    "country": "Nicaragua",
    "code": "NI",
    "dial_code": "+505",
    "phLength": 8
  },
  {
    "country": "Niger",
    "code": "NE",
    "dial_code": "+227",
    "phLength": 8
  },
  {
    "country": "Nigeria",
    "code": "NG",
    "dial_code": "+234",
    "phLength": 8
  },
  {
    "country": "Niue",
    "code": "NU",
    "dial_code": "+683",
    "phLength": 4
  },
  {
    "country": "Northern Mariana Islands",
    "code": "MP",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Oman",
    "code": "OM",
    "dial_code": "+968",
    "phLength": 8
  },
  {
    "country": "Pakistan",
    "code": "PK",
    "dial_code": "+92",
    "phLength": 10
  },
  {
    "country": "Palau",
    "code": "PW",
    "dial_code": "+680",
    "phLength": 7
  },
  {
    "country": "Panama",
    "code": "PA",
    "dial_code": "+507",
    "phLength": 8
  },
  {
    "country": "Paraguay",
    "code": "PY",
    "dial_code": "+595",
    "phLength": 9
  },
  {
    "country": "Peru",
    "code": "PE",
    "dial_code": "+51",
    "phLength": 9
  },
  {
    "country": "Philippines",
    "code": "PH",
    "dial_code": "+63",
    "phLength": 10
  },
  {
    "country": "Poland",
    "code": "PL",
    "dial_code": "+48",
    "phLength": 9
  },
  {
    "country": "Puerto Rico",
    "code": "PR",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Qatar",
    "code": "QA",
    "dial_code": "+974",
    "phLength": 8
  },
  {
    "country": "Romania",
    "code": "RO",
    "dial_code": "+40",
    "phLength": 10
  },
  {
    "country": "Saint Lucia",
    "code": "LC",
    "dial_code": "+1",
    "phLength": 10
  },
  {
    "country": "Samoa",
    "code": "WS",
    "dial_code": "+685",
    "phLength": 5
  },
  {
    "country": "Saudi Arabia",
    "code": "SA",
    "dial_code": "+966",
    "phLength": 9
  },
  {
    "country": "Serbia",
    "code": "RS",
    "dial_code": "+381",
    "phLength": 8
  },
  {
    "country": "Slovakia",
    "code": "SK",
    "dial_code": "+421",
    "phLength": 9
  },
  {
    "country": "Solomon Islands",
    "code": "SB",
    "dial_code": "+677",
    "phLength": 7
  },
  {
    "country": "Somalia",
    "code": "SO",
    "dial_code": "+252",
    "phLength": 8
  },
  {
    "country": "South Africa",
    "code": "ZA",
    "dial_code": "+27",
    "phLength": 9
  },
  {
    "country": "Sri Lanka",
    "code": "LK",
    "dial_code": "+94",
    "phLength": 7
  },
  {
    "country": "Taiwan",
    "code": "TW",
    "dial_code": "+886",
    "phLength": 9
  },
  {
    "country": "Tanzania",
    "code": "TZ",
    "dial_code": "+255",
    "phLength": 6
  },
  {
    "country": "Thailand",
    "code": "TH",
    "dial_code": "+66",
    "phLength": 9
  },
  {
    "country": "Togo",
    "code": "TG",
    "dial_code": "+228",
    "phLength": 8
  },
  {
    "country": "Tunisia",
    "code": "TN",
    "dial_code": "+216",
    "phLength": 8
  },
  {
    "country": "Turkey",
    "code": "TR",
    "dial_code": "90",
    "phLength": 10
  },
  {
    "country": "Ukraine",
    "code": "UA",
    "dial_code": "+380",
    "phLength": 9
  },
  {
    "country": "United Arab Emirates",
    "code": "AE",
    "dial_code": "+971",
    "phLength": 9
  },
  {
    "country": "Venezuela",
    "code": "VE",
    "dial_code": "+58",
    "phLength": 7
  },
  {
    "country": "Vietnam",
    "code": "VN",
    "dial_code": "+84",
    "phLength": 9
  },
  {
    "country": "Yemen",
    "code": "YE",
    "dial_code": "+967",
    "phLength": 9
  },
  {
    "country": "Zambia",
    "code": "ZM",
    "dial_code": "+260",
    "phLength": 9
  },
  {
    "country": "Zimbabwe",
    "code": "ZW",
    "dial_code": "+263",
    "phLength": 9
  }
];*/
