# Harvest Realty LLC Website

A professional, responsive website for Harvest Realty LLC - Premier Real Estate Services in Pennsylvania and New Jersey.

## Features

- **Modern Design**: Elegant burgundy and gold color scheme matching the company logo
- **Responsive Layout**: Fully optimized for desktop, tablet, and mobile devices
- **Property Showcase**: Dynamic property listings with filtering capabilities
- **Contact Forms**: Easy-to-use contact form for client inquiries
- **Calendly Integration**: Schedule property viewings directly through the website
- **SEO Optimized**: Proper meta tags and semantic HTML structure
- **Fast Loading**: Optimized images and efficient CSS/JS

## File Structure

```
harvest-realty-website/
├── index.html              # Main homepage
├── privacy.html            # Privacy policy page
├── terms.html             # Terms of use page
├── hrg-logo.png           # Company logo
├── css/
│   └── styles.css         # Main stylesheet
├── js/
│   └── main.js            # JavaScript functionality
└── README.md              # This file
```

## Setup Instructions

### 1. Basic Setup

Simply upload all files to your web hosting server maintaining the folder structure:

```
your-domain.com/
├── index.html
├── privacy.html
├── terms.html
├── hrg-logo.png
├── css/
│   └── styles.css
└── js/
    └── main.js
```

### 2. Calendly Integration

To enable appointment scheduling:

1. Sign up for a free Calendly account at https://calendly.com
2. Create two event types:
   - "Property Showing" for property tours
   - "Rental Availability Inquiry" for rental inquiries
3. Configure both events to send confirmations to:
   - prasadabe@comcast.net
   - jacobabe99@gmail.com
4. Open `index.html` and replace `YOUR_CALENDLY_USERNAME` with your actual Calendly username (around line 258)

### 3. Customization

#### Adding More Properties

Edit `js/main.js` and add more property objects to the `properties` array:

```javascript
{
    title: "Your Property Name",
    price: "$XXX,XXX",
    location: "City, State",
    beds: X,
    baths: X,
    image: "image-url-here"
}
```

#### Updating Contact Information

- Edit contact details in `index.html` (Contact Section)
- Update footer information in all HTML files
- Modify the contact form submission endpoint if using a backend service

#### Changing Colors

All colors are defined as CSS variables in `css/styles.css`:

```css
:root {
    --burgundy: #8B2E2E;
    --gold: #D4AF37;
    --cream: #F5F1E8;
    /* etc. */
}
```

### 4. Optional Enhancements

#### Email Form Submission

To make the contact form functional, you can:

1. **Use a Form Service**: Services like Formspree, Netlify Forms, or EmailJS
2. **Backend Integration**: Connect to your own server with PHP/Node.js
3. **Example with Formspree**:
   ```html
   <form action="https://formspree.io/f/YOUR_FORM_ID" method="POST">
   ```

#### Property Search Database

To connect the search form to a real database:

1. Set up a backend API (Node.js, PHP, Python, etc.)
2. Modify the `searchProperties()` function in `js/main.js`
3. Make AJAX calls to your API endpoint
4. Filter and display results dynamically

#### Google Maps Integration

To add property location maps:

1. Get a Google Maps API key
2. Add the Maps JavaScript API script to your HTML
3. Create map instances for each property

## Browser Compatibility

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## Performance Tips

1. **Optimize Images**: Compress property images before uploading
2. **Enable Caching**: Configure your server to cache CSS/JS files
3. **Use CDN**: Consider using a CDN for faster global delivery
4. **Minify Files**: Minify CSS and JS files for production

## SEO Recommendations

1. Add Google Analytics tracking code
2. Submit sitemap to Google Search Console
3. Add structured data markup for properties
4. Optimize meta descriptions for each page
5. Create blog content for better search rankings

## Support & Maintenance

### Common Issues

**Problem**: Logo not displaying
- **Solution**: Ensure `hrg-logo.png` is in the root directory

**Problem**: Calendly widget not loading
- **Solution**: Check that you've replaced `YOUR_CALENDLY_USERNAME` with your actual username

**Problem**: Forms not submitting
- **Solution**: Configure a form backend service (see Optional Enhancements)

### Regular Updates

- Update property listings regularly
- Keep contact information current
- Review and respond to form submissions promptly
- Check for broken links monthly
- Update privacy policy and terms as needed

## Security Considerations

- Use HTTPS for your website (SSL certificate)
- Validate all form inputs
- Implement CAPTCHA to prevent spam
- Regular security audits
- Keep dependencies updated

## Credits

**Design & Development**: Professional website for Harvest Realty LLC  
**Fonts**: Google Fonts (Cormorant Garamond, Montserrat)  
**Icons**: Unicode emoji characters  
**Images**: Unsplash (replace with your own property photos)

## License

© 2026 Harvest Realty LLC. All rights reserved.

## Contact

For website support or inquiries:
- Email: prasadabe@comcast.net
- Email: jacobabe99@gmail.com

---

**Note**: This is a static website template. For dynamic features like property database, user accounts, or advanced search, you'll need to integrate a backend system or use a CMS platform.
