# Harvest Realty LLC Website

Professional website for Harvest Realty LLC - Real Estate Services in PA & NJ

## Contact Information

**Main Office:**
- Phone: 267-900-8011
- Address: 2481 Napfle Ave, Philadelphia, PA 19152

**Prasad Abraham** - Broker/Owner
- Phone: 215-519-4096
- Email: Prasadabe@comcast.net

**Jacob Abraham** - Sales Agent (PA)
- Phone: 215-519-8916
- Email: Jacobabe99@gmail.com

**Dyson Daniel** - Sales Agent (PA)
- Phone: (267) 290-0963
- Email: dysondanielpa@gmail.com

## Service Areas
- Philadelphia County, PA
- Bucks County, PA
- Montgomery County, PA
- Select areas in New Jersey

## Files Included
- `index.html` - Complete website (all CSS/JS embedded)
- `hrg-logo.png` - Company logo
- `README.md` - This file

## Quick Setup

1. Extract the zip file
2. Upload `index.html` and `hrg-logo.png` to your web server
3. Update Calendly URL (line 1661 in index.html):
   - Replace `YOUR_CALENDLY_USERNAME` with your Calendly username

## Features

✅ Fully responsive design
✅ Agent profile section with all 3 agents
✅ Property search form
✅ Contact form with all agent emails
✅ Office address and phone numbers
✅ Calendly scheduling integration
✅ Mobile-friendly navigation

## Customization

### Add More Properties
Edit the `properties` array in the `<script>` section (around line 1563):

```javascript
{
    title: "Property Name",
    price: "$XXX,XXX",
    location: "County, State",
    beds: X,
    baths: X,
    image: "image-url"
}
```

### Update Colors
Edit CSS variables (around line 25):
```css
--burgundy: #8B2E2E;
--gold: #D4AF37;
--cream: #F5F1E8;
```

## Browser Support
Chrome, Firefox, Safari, Edge (latest versions)
iOS Safari, Chrome Mobile

© 2026 Harvest Realty LLC. All rights reserved.
