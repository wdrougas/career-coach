import { useEffect, useState } from 'react'

function JobsPage() {
  const [jobs, setJobs] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    fetch('http://localhost:3000/jobs')
      .then((response) => {
        if (!response.ok) {
          throw new Error('Failed to fetch jobs')
        }

        return response.json()
      })
      .then((data) => {
        setJobs(data)
        setLoading(false)
      })
      .catch((error) => {
        setError(error.message)
        setLoading(false)
      })
  }, [])

  if (loading) {
    return <p>Loading jobs...</p>
  }

  if (error) {
    return <p>Error: {error}</p>
  }

  return (
    <main>
      <h1>Jobs</h1>

      {jobs.length === 0 ? (
        <p>No jobs found.</p>
      ) : (
        <ul>
          {jobs.map((job) => (
            <li key={job.id}>
              <h2>{job.title}</h2>
              <p>{job.company}</p>
              <p>{job.description}</p>
            </li>
          ))}
        </ul>
      )}
    </main>
  )
}

export default JobsPage