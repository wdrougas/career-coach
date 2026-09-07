import { useNavigate } from 'react-router-dom'
import JobForm from '../../features/jobs/JobForm'

function NewJobPage() {
  const navigate = useNavigate()

  function handleJobSaved() {
    navigate('/jobs')
  }

  return (
  // Temporarily hardcoding ID here. Need to refactor once authentication is setup
    <JobForm
      userId={1}
      onJobSaved={handleJobSaved}
    />
  )
}

export default NewJobPage