# Career Coach

Career Coach is an AI-powered web application that helps software engineers optimize their resumes, evaluate job opportunities, and prepare for interviews.

The application uses Ruby on Rails for the backend, React for the frontend, and modern LLMs to provide personalized, actionable career guidance.

## MVP User Flow

The initial version of Career Coach will answer one core question:

> **"Given my resume and a job posting, how well do I match?"**

### User Journey

```text
User signs in
      │
      ▼
Uploads resume (PDF)
      │
      ▼
Creates a Job
      │
      ▼
Pastes job description
      │
      ▼
Clicks "Analyze"
      │
      ▼
Receives AI-powered feedback:
  • Match score
  • Missing skills
  • Resume improvements
  • Suggested interview questions
```

### MVP Features

- Upload and manage resumes
- Create and manage job postings
- Analyze a resume against a job description using AI
- Receive actionable feedback, including:
  - Match score
  - Missing or underrepresented skills
  - Resume improvement suggestions
  - Potential interview questions tailored to the role

### Future Enhancements

- User authentication
- Resume version history
- Cover letter generation
- Job application tracking
- Interview preparation mode
- AI-powered career roadmap
- Personalized learning recommendations
