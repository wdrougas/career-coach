import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { getJob, deleteJob } from '../../features/jobs/jobsApi'
import { Link } from 'react-router-dom'

function JobDetailPage() {
  const { id } = useParams()
  const navigate = useNavigate()

  const [job, setJob] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)
  const [deleting, setDeleting] = useState(false)

  useEffect(() => {
    async function loadJob() {
      try {
        const data = await getJob(id)
        setJob(data)
      } catch (error) {
        setError(error.message)
      } finally {
        setLoading(false)
      }
    }

    loadJob()
  }, [id])

  if (loading) {
    return <p>Loading job...</p>
  }

  if (error) {
    return <p>Error: {error}</p>
  }

  async function handleDelete() {
    const confirmed = window.confirm(
      'Are you sure you want to delete this job?'
    )

    if (!confirmed) {
      return
    }

    setDeleting(true)

    try {
      await deleteJob(job.id)
      navigate('/jobs')
    } catch (error) {
      setError(error.message)
      setDeleting(false)
    }
  }

  return (
    <main>
      <h1>{job.title}</h1>
      <h2>{job.company}</h2>
      <p>{job.description}</p>
      <Link to={`/jobs/${job.id}/edit`}>
        Edit Job
      </Link>
      <button onClick={handleDelete} disabled={deleting}>
        {deleting ? 'Deleting...' : 'Delete Job'}
      </button>
    </main>
  )
}

export default JobDetailPage