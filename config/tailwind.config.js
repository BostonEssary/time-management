const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
       primary: {
          DEFAULT: '#2D6A4F',    // Main primary color
          50: '#F0F9F4',         // Lightest shade
          100: '#DCEFE3',
          200: '#B8DBCA',
          300: '#7FC2A4',
          400: '#40916C',        // Lighter variant
          500: '#2D6A4F',        // Same as DEFAULT
          600: '#1B4332',        // Darker variant
          700: '#133226',
          800: '#0C211A',
          900: '#06110D',        // Darkest shade
          light: '#40916C',      // Convenience light reference
          dark: '#133226',       // Convenience dark reference
        },
        // Common system colors
        error: '#DC2626',        // Red for errors
        warning: '#F59E0B',      // Amber for warnings
        success: '#16A34A',      // Green for success
        info: '#2563EB',        
        }
      }
    },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
