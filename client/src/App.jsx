import { BrowserRouter, Routes, Route } from 'react-router-dom'
import NavBar from './components/NavBar'
import HomePage from './pages/HomePage'
import JobsPage from './features/jobs/JobsPage'
import JobDetailPage from './pages/jobs/JobDetailPage'
import NewJobPage from './pages/jobs/NewJobPage'
import EditJobPage from './pages/jobs/EditJobPage'

function App() {
  return (
    <BrowserRouter>
      <NavBar />

      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/jobs" element={<JobsPage />} />
        <Route path="/jobs/new" element={<NewJobPage />} />
        <Route path="/jobs/:id" element={<JobDetailPage />} />
        <Route path="/jobs/:id/edit" element={<EditJobPage />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App