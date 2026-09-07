import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { getJob } from '../../features/jobs/jobsApi'
import JobForm from '../../features/jobs/JobForm'

function EditJobPage() {
  const { id } = useParams()
  const navigate = useNavigate()

  const [job, setJob] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

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

  function handleJobSaved() {
    navigate(`/jobs/${id}`)
  }

  if (loading) {
    return <p>Loading job...</p>
  }

  if (error) {
    return <p>Error: {error}</p>
  }

  return (
    <main>
      {/* Temporarily hardcoding ID here. Need to refactor once authentication is setup */}
      <JobForm
        userId={1}
        job={job}
        onJobSaved={handleJobSaved}
      />
    </main>
  )
}

export default EditJobPage