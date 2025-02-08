const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  safelist: [
    // Effect theme classes
    'bg-sky-200',
    'bg-yellow-200',
    'bg-orange-200',
    'bg-pink-200',
    'bg-purple-200',
    'bg-green-200',
    'bg-fuchsia-200',
    'bg-red-200',
    'bg-amber-200',
    'bg-blue-200',
    'text-sky-700',
    'text-yellow-700',
    'text-orange-700',
    'text-pink-700',
    'text-purple-700',
    'text-green-700',
    'text-fuchsia-700',
    'text-red-700',
    'text-amber-700',
    'text-blue-700'
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
        secondary: {
          DEFAULT: '#FF8E6E',    // Main secondary color (coral)
          50: '#FFF5F2',         // Lightest tint - Very subtle coral background
          100: '#FFE6DF',        // Light tint - Soft coral for hover states
          200: '#FFD0C2',        // Lighter tint - Subtle coral accents
          300: '#FFB4A0',        // Light-medium tint - Stronger coral accents
          400: '#FFA186',        // Medium-light - Prominent coral
          500: '#FF8E6E',        // Base coral color (same as DEFAULT)
          600: '#F27A59',        // Darker tone - Good for interactive elements
          700: '#E56547',        // Dark tone - Strong emphasis
          800: '#D15035',        // Darker shade - Very strong emphasis
          900: '#BC3B23',        // Darkest shade - Maximum contrast
          light: '#FFA186',      // Convenience light reference (400)
          dark: '#E56547',       // Convenience dark reference (700)
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
